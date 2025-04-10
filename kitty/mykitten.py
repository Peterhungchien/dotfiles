from os import getenv
import subprocess
from kitty.boss import Boss
import json

def fzf_select(options):
    """
    Pipes a list of options to fzf and returns the selected item.

    Args:
        options (list): A list of strings to select from.

    Returns:
        str: The selected item, or None if nothing was selected.
    """
    process = subprocess.Popen(
        [
            "fzf",
            "--delimiter=\t",
            "--border",
            "--border-label",
            "TITLE ID CWD",
            "--preview",
            f"kitten @ --to {getenv('KITTY_LISTEN_ON')} get-text --ansi -m id:{{2}}",
         ],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    
    output, _ = process.communicate('\n'.join(options))
    
    if process.returncode == 0:
        return output.strip()
    else:
        return None

def ls_window():
    kitty_ls_res = subprocess.run(
        ['kitten', '@', "ls"],
        capture_output=True,
        check=True,
        text=True
    )
    parsed_ls_res = json.loads(kitty_ls_res.stdout)
    window_ls = []
    for system_window in parsed_ls_res:
        if not system_window['is_focused']:
            continue
        else:
            for tab in system_window['tabs']:
                for window in tab['windows']:
                    if window['is_focused']:
                        continue
                    # window_ls.append(f"{window["title"].replace("\t"," ")}\t{window["id"]}\t{window["cwd"].replace("\t"," ")}\t")
                    window_ls.append(f"{window["title"]}\t{window["id"]}\t{window["cwd"]}\t")
    return window_ls

def main(args: list[str]) -> str:
    # this is the main entry point of the kitten, it will be executed in
    # the overlay window when the kitten is launched
    answer = fzf_select(ls_window())
    if not answer:
        # if the user pressed Ctrl-C or Esc, we return None
        answer = ""
    # whatever this function returns will be available in the
    # handle_result() function
    return answer

def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    # get the kitty window into which to paste answer
    w = boss.window_id_map.get(target_window_id)
    answer = getenv("KITTY_PID")
    if w is not None:
        w.paste_text(answer)

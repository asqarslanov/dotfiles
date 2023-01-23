import inspect
import sys


def gen_vars():
    """Restores values of variable files to default"""

    pass


def get_active_window():
    """…"""

    pass


def get_brightness():
    """…"""

    pass


def get_date():
    """…"""

    pass


def get_keyboard_layout():
    """…"""

    pass


def get_time():
    """…"""

    pass


def get_volume():
    """…"""

    pass


def help():  # Redefined default function
    """Prints this message"""

    commands = inspect.getmembers(sys.modules[__name__], inspect.isfunction)

    for name, function in commands:
        name = name.replace("_", "-")
        print(name, inspect.getdoc(function), sep="\t")


def lock_screen():
    """…"""

    pass


def set_brightness():
    """…"""

    pass


def set_volume():
    """…"""

    pass


def toggle_bar():
    """…"""

    pass


def toggle_gaps():
    """…"""

    pass


def toggle_keyboard_layout():
    """…"""

    pass


def toggle_inactive_opacity():
    """…"""

    pass

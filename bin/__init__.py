from fabric.colors import *
from paver.easy import *


def do_children_if_svn(func):
    for d in path.getcwd().dirs():
        if (d / '.svn').exists():
            print cyan(d.name, bold = True)
            func(d)

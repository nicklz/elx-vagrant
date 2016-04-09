from os import path, sep
from string import join

from fabric.api import local


class Compass(object):

    #=======================================================================
    # defaults
    #=======================================================================
    _command    = 'compass'
    style       = 'nested' # nested (default), expanded, compact, compressed.
    comments    = True
    force       = False

    #=======================================================================
    # src_dir property
    #=======================================================================
    @property
    def src_dir(self):
        """The source directory where you keep your sass/scss stylesheets."""
        return self._src_dir

    @src_dir.setter
    def src_dir(self, value):
        self.css_dir = path.split(value)[0]
        self._src_dir = self._fix_os_path(value)

    @src_dir.deleter
    def src_dir(self):
        del self._src_dir

    #=======================================================================
    # css_dir property
    #=======================================================================
    @property
    def css_dir(self):
        """The target directory where you keep your css stylesheets."""
        return self._css_dir

    @css_dir.setter
    def css_dir(self, value):
        self._css_dir = self._fix_os_path(value)

    @css_dir.deleter
    def css_dir(self):
        del self._css_dir

    #=======================================================================
    # scss_file property
    #=======================================================================
    @property
    def scss_file(self):
        return self._scss_file

    @scss_file.setter
    def scss_file(self, value):
        self._scss_file = self._fix_os_path(value)

    @scss_file.deleter
    def scss_file(self):
        del self._scss_file

    #=======================================================================
    # dunder methods
    #=======================================================================
    def __init__(self, src_dir, **kwargs):
        """
        Args:
            - src_dir       (string)
                The source directory where you keep your sass/scss stylesheets.
        Flags:
            - force         (bool, default:False)
                Allows compass to overwrite existing files.

            - style         (string, default:nested)
                Select a CSS output mode.
                One of: nested (default), expanded, compact, compressed.

            - comments      (bool, default:True)
                Enable line comments.
        """
        self.src_dir = src_dir
        self.style = kwargs.pop('style', self.style)
        self.comments = kwargs.pop('comments', self.comments)
        self.force = kwargs.pop('force', self.force)

    #=======================================================================
    # private methods
    #=======================================================================
    def _run(self, fn, scss_file=None, *args, **kwargs):
        cmd = join((self._command, fn), ' ')
        if not scss_file is None:
            self.scss_file = scss_file
            cmd += ' ' + self.scss_file
        if len(args):
            cmd += ' ' + join(args, ' ')
        cmd += ' --sass-dir %s --css-dir %s' % (self.src_dir, self.css_dir)
        style = kwargs.pop('style', self.style)
        if style != 'nested':
            cmd += ' -s %s' % style
        comments = kwargs.pop('comments', self.comments)
        if not comments:
            cmd += ' --no-line-comments'
        force = kwargs.pop('force', self.force)
        if force:
            cmd += ' --force'
        local(cmd)

    def _fix_os_path(self, path):
        """Compass apparently does not support os.sep, so we convert paths to linux format"""
        return path.replace(sep, '/')

    #=======================================================================
    # public methods
    #=======================================================================
    def watch(self, *args, **kwargs):
        flags = dict(style='expanded')
        flags.update(**kwargs) # override watch flags with kwargs
        self._run('watch', *args, **flags)

    def compile(self, *args, **kwargs):
        flags = dict(style='compressed', comments=False, force=True)
        flags.update(**kwargs) # override compile flags with kwargs
        self._run('compile', *args, **flags)

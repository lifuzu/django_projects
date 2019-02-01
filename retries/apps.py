from django.apps import AppConfig


class RetriesConfig(AppConfig):

    name = 'retries'

    def coolfunction(self, parameter, option=1000):
        """
        This is a docstring.

        Parameters
        ----------
        option : int, optional, default = 10
            Description of the option.

        another : int, optional, default = 200
            Description of another option.
        """
        pass

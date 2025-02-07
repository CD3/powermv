import jinja2


class Renderer:
    pass


class Jinja2Renderer:
    def __init__(self, template):
        self.__env = jinja2.Environment()
        self.__template_text = template

        def pad(input, num):
            return ("{:0" + str(num) + "}").format(input)

        def inc(input, num=1):
            return input + num

        self.__env.filters["pad"] = pad
        self.__env.filters["inc"] = inc
        self.__template = self.__env.from_string(self.__template_text)

    def render(self, ctx: dict):
        if ctx is None:
            ctx = {}
        return self.__template.render(**ctx)

import re

import pyparsing


class Matcher:
    pass


class RegexMatcher(Matcher):
    def __init__(self, pattern: str):
        self.__pattern = pattern
        self.__regex = re.compile(pattern)

    def get_match_tokens(self, text: str):
        toks = {}
        m = self.__regex.match(text)
        if m:
            unnamed_groups = m.groups()
            named_groups = m.groupdict()

            for k in named_groups:
                val = named_groups[k]
                try:
                    val = int(val)
                except:
                    pass

                toks[k] = val

            for i, val in enumerate(unnamed_groups):
                try:
                    val = int(val)
                except:
                    pass

                toks[f"_{i+1}"] = val

        return toks

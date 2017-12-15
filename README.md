# NAME

imarpa - use the Marpa parser on the command line

# USAGE

**imarpa** \[_OPTION_\]... _GRAMMAR_ \[FILE\]...

Options:

    --all               output all parse trees
    --chomp             remove trailing newline from input
    --man               display the full manpage
    --marpa=RELEASE     choose 2 for Marpa::R2 (default) or 3 for Marpa::R3
    -G KEY=VALUE        grammar arguments
    -M MODULE           load a Perl module, like perl's -M switch
    -R KEY=VALUE        recognizer arguments
    -h, -?, --help      display this help message
    -t FORMAT, --to FORMAT output format, defaults to "perl"

    GRAMMAR     a Marpa grammar
    FILE        input files, otherwise read from STDIN

Output formats:
json,
perl,
yaml.

# OPTIONS

- **--man**

    Display the full manpage.

- **--marpa 2**
- **--marpa 3**

    Choose which release of Marpa to use.
    [Marpa::R2](https://metacpan.org/pod/Marpa::R2) is the current stable release.
    [Marpa::R3](https://metacpan.org/pod/Marpa::R3) is in alpha.
    You will need to have that version of Marpa installed.

- **-G** _KEY_=_VALUE_

    Set Grammar options.

    If the key contains hyphens, they are substituted with underscores.

    Keys for Marpa::R2:
    (none).
    See [Marpa::R2::Scanless::G](https://metacpan.org/pod/Marpa::R2::Scanless::G) for details.

    Keys for Marpa::R3:
    exhaustion,
    ranking\_method,
    rejection,
    semantics\_package.
    See [Marpa::R3::Grammar](https://metacpan.org/pod/Marpa::R3::Grammar) for details.

    Example:

        $ imarpa --marpa 3 -G ranking_method=high_rule_only "..." <input.txt

    See also:
    [-R](#r-key-value)

- **-R** _KEY_=_VALUE_

    Set recognizer options.

    If the key contains hyphens, they are substituted with underscores.

    Keys for Marpa::R2:
    end,
    exhaustion,
    max\_parses,
    ranking\_method,
    rejection,
    semantics\_package
    too\_many\_earley\_items
    trace\_terminals,
    trace\_values.
    See [Marpa::R2::Scanless::R](https://metacpan.org/pod/Marpa::R2::Scanless::R) for details.

    Keys for Marpa::R3:
    too\_many\_earley\_items,
    trace\_terminals.
    See [Marpa::R3::Recognizer](https://metacpan.org/pod/Marpa::R3::Recognizer) for details.

    Example:

        $ imarpa -R trace_terminals=1 "..." <input.txt

    See also:
    [-G](#g-key-value)

- **--to** _FORMAT_
- **-t** _FORMAT_

    Specify an output format.

    Formats are not case-sensitive.

    Supported formats:

    - JSON

        JSON output.
        Uses one of
        [Cpanel::JSON::XS](https://metacpan.org/pod/Cpanel::JSON::XS) or
        [JSON::PP](https://metacpan.org/pod/JSON::PP).

    - Perl

        Pretty-printed Perl data structure.
        Uses one of
        [Data::Dump](https://metacpan.org/pod/Data::Dump) or
        [Data::Dumper](https://metacpan.org/pod/Data::Dumper).

    - YAML

        YAML output.
        Uses one of
        [YAML](https://metacpan.org/pod/YAML),
        [YAML::Tiny](https://metacpan.org/pod/YAML::Tiny), or
        [CPAN::Meta::YAML](https://metacpan.org/pod/CPAN::Meta::YAML).

# EXIT STATUS

Exits with zero status if the input was parsed successfully.
Exits with non-zero status otherwise.

# DESCRIPTION

TODO

# BUGS AND LIMITATIONS

You are unable to set values for **--recce** and **--grammar** arguments
where those values are non-strings.
In particular, this precludes event handlers.

**Security:**
The semantics in the grammar DSL may invoke arbitrary Perl subroutines.
This program must not be used with intrusted input.

# DEPENDENCIES

If you use **--marpa 2** (default),
then you will have to install [Marpa::R2](https://metacpan.org/pod/Marpa::R2).

If you wish to use **--marpa 3**,
then you will have to install [Marpa::R3](https://metacpan.org/pod/Marpa::R3).

Before you can use a specific output format,
you will have to install the corresponding module.

# AUTHOR

Lukas Atkinson (cpan: AMON) <amon@cpan.org>

# LICENSE AND COPYRIGHT

Copyright 2017 Lukas Atkinson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see &lt;https://www.gnu.org/licenses/>.

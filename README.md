# NAME

imarpa - use the Marpa parser on the command line

# USAGE

**imarpa** \[_OPTION_\]... \[_GRAMMAR_\] \[_INPUT_\]

Options:

    --all               output all parse trees
    --bnf GRAMMAR       provide grammar as command line arg, not file
    --chomp             remove trailing newline from input
    -e CODE             eval Perl code
    -G KEY=VALUE        grammar arguments
    -h, -?, --help      display this help message and exit
    --input DATA        provide input as command line arg, not file
    -M MODULE           load a Perl module, like perl's -M switch
    --man               display the full manpage
    --marpa RELEASE     choose 2 for Marpa::R2 (default) or 3 for Marpa::R3
    -R KEY=VALUE        recognizer arguments
    --semantics-package NAME    set semantics_package grammar/recce argument
    --to FORMAT         output format, defaults to "perl"
    --version           display version and exit

    GRAMMAR     BNF file
    INPUT       input file

Output formats:
json,
perl,
str,
yaml.

# DESCRIPTION

The **imarpa** tool allows you to experiment with Marpa grammars on the command line.
It is not an interactive REPL.

Example: Experimenting with a simple, highly ambiguous grammar:

    $ imarpa --input '*=*=*=*' --to json --all <<'END'
      :default ::= action => [values]
      S ::= '*' | S '=' S
    END

Output:

    [[[["*"],"=",["*"]],"=",["*"]],"=",["*"]]
    [[["*"],"=",[["*"],"=",["*"]]],"=",["*"]]
    [["*"],"=",[[["*"],"=",["*"]],"=",["*"]]]
    [["*"],"=",[["*"],"=",[["*"],"=",["*"]]]]
    [[["*"],"=",["*"]],"=",[["*"],"=",["*"]]]

The command line arguments work largely like a Perl script:

The _GRAMMAR_ is usually a file name.
You can also use the **--bnf** option
to write the grammar inside a command line argument.
This is like Perl's "-e" or "-E" option.
If no _GRAMMAR_ is provided, the grammar is read from STDIN.

The _INPUT_ is also a file name.
Alternatively, you can use the **--input** option.
If no _INPUT_ is provided, the input is read from STDIN.

Either _GRAMMAR_ or _INPUT_ have to be specified explicitly
as at most one of them can be read from STDIN.

# OPTIONS

- **--all**

    Display all parse trees.
    This is useful when debugging ambiguous grammars.

    If this option is not used,
    the behaviour between Marpa releases 2 and 3 differs significantly:
    Marpa::R2 will return the first parse result.
    Marpa::R3 will die on ambiguous parses.

- **--bnf GRAMMAR**

    Specify a literal grammar snippet, instead of reading it from a file.

    If the **--bnf** option is provided multiple times,
    the grammar snippets are concatenated with a newline in between.

- **--chomp**

    Remove trailing newline from input.

    Some input methods such as
    here-strings `imarpa ... <<<'input'`
    or echo ` echo 'input' | imarpa ... `
    add a trailing newline.
    Your grammar may not want to handle that newline.
    In that case, use the --chomp option to remove that newline.

- **-e** _CODE_

    Evaluate Perl code.
    This is very similar to the `perl -e ...` option.
    If a **--semantics-package** was specified,
    the code is compiled in that package.

- **--input DATA**

    Specify the input data, instead of reading it from a file.

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

    See also: **-R**

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

    See also: **-G**

- **--semantics-package** _NAME_

    Specify the semantics package.

    This option simplifies switching between Marpa R2 and R3.
    It is equivalent
    to `-R semantics_package=NAME` for Marpa::R2, and
    to `-G semantics_package=NAME` for Marpa::R3.

    But note that the interface for semantics has changed,
    so it is not possible in general to reuse the same semantics.

- **--to** _FORMAT_
- **-t** _FORMAT_

    Specify an output format. Defaults to Perl.

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

    - Str

        Print the output directly.
        This is only useful if your AST consists of
        objects with overloaded stringification.
        Otherwise, you'll only get useless output like `ARRAY(0x123CAFE)`.

    - YAML

        YAML output.
        Uses one of
        [YAML](https://metacpan.org/pod/YAML),
        [YAML::Tiny](https://metacpan.org/pod/YAML::Tiny), or
        [CPAN::Meta::YAML](https://metacpan.org/pod/CPAN::Meta::YAML).

# BUGS AND LIMITATIONS

You are unable to set values for **-R** and **-G** arguments
where those values are non-strings.
In particular, this precludes event handlers.

**Security:**
This program must not be used with untrusted input.
The semantics in the grammar DSL may invoke arbitrary Perl subroutines.
With the **-e** option, arbitrary code can be executed directly.

## Support

Homepage: [https://github.com/latk/p5-MarpaX-App-imarpa](https://github.com/latk/p5-MarpaX-App-imarpa)

Bug Tracker: [https://github.com/latk/p5-MarpaX-App-imarpa/issues](https://github.com/latk/p5-MarpaX-App-imarpa/issues)

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

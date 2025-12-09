# Bash completion for docmake function
# Save this file as: ~/.bash_completion.d/docmake or include it in your .bashrc

_docmake_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # All available options
    opts="--debug --aggressive --vecttrap --ninja --only-cmake -n --dryrun --dry-run --runtests --jobs --extra --builddir --installdir --cmake-options --mit --no-f2py -h --help"

    # Handle options that require arguments
    case "${prev}" in
        --jobs)
            # Suggest common job numbers
            COMPREPLY=( $(compgen -W "1 2 4 8 10 12 16 20 24 32" -- ${cur}) )
            return 0
            ;;
        --extra)
            # Allow free text for extra names
            return 0
            ;;
        --builddir|--installdir)
            # Offer directory completion
            COMPREPLY=( $(compgen -d -- ${cur}) )
            return 0
            ;;
        --cmake-options)
            # Suggest common CMake options
            COMPREPLY=( $(compgen -W "-D -DCMAKE_" -- ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac

    # Complete with available options if current word starts with -
    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}

# Register the completion function for docmake
complete -F _docmake_completion docmake

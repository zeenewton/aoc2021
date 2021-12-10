lines = readlines(ARGS[1])


"""
): 3 points.
]: 57 points.
}: 1197 points.
>: 25137 points.
"""

function get_syntax_score(token)
    if token == ')'
        return 3
    elseif token == ']'
        return 57
    elseif token == '}'
        return 1197
    elseif token == '>'
        return 25137
    else
        return nothing
    end
end

function matches(token1, token2)
    return (token1 == '(' && token2 == ')') || (token1 == '[' && token2 == ']') || (token1 == '{' && token2 == '}') || (token1 == '<' && token2 == '>')
end

function solution1(lines)
    beginnings = "([{<"
    ends = ")]}>"
    total = 0
    for line in lines
        line_list = []
        for char in line
            if in(char, beginnings)
                push!(line_list, char)
            else
                beg = pop!(line_list)
                if !matches(beg, char)
                    total += get_syntax_score(char)
                    break
                end
            end
        end
    end
    return total
end

"""
): 1 point.
]: 2 points.
}: 3 points.
>: 4 points.
"""
function get_completion_token_score(token)
    if token == ')'
        return 1
    elseif token == ']'
        return 2
    elseif token == '}'
        return 3
    elseif token == '>'
        return 4
    end
end

function get_completion_line_score(line_chars)
    total = 0
    for char in line_chars
        total *= 5
        total += get_completion_token_score(char)
    end
    return total
end


complements = Dict()
complements['('] = ')'
complements['['] = ']'
complements['{'] = '}'
complements['<'] = '>'

function solution2(lines)
    beginnings = "([{<"
    ends = ")]}>"
    scores = []

    for line in lines
        broken = false
        line_list = []
        for char in line
            if in(char, beginnings)
                push!(line_list, char)
            else
                beg = pop!(line_list)
                if !matches(beg, char)
                    broken = true
                    break
                end
            end
        end
        if !broken
            completion_chars = []
            for char in reverse(line_list)
                append!(completion_chars, complements[char])
            end
            append!(scores, get_completion_line_score(completion_chars))
        end
    end
    med = round(Int, length(scores) / 2)
    return sort(scores)[med]
end

println(solution1(lines))

println(solution2(lines))

lines = readlines(ARGS[1])

function process_lines(lines)
    increased = 0
    prev = nothing
    for i in lines
        int_val = parse(Int, i)
        if isnothing(prev)
            prev = int_val
        else
            if int_val > prev
                increased += 1
            end
            prev = int_val
        end
    end
    return increased
end

function process_lines_2(lines)
    increased = 0
    prev = []
    for i in lines
        int_val = parse(Int, i)
        if length(prev) < 3
            append!(prev, int_val)
        else
            append!(prev, int_val)
            if sum(prev[2:4]) > sum(prev[1:3])
                increased += 1
            end
            popfirst!(prev)
        end
    end
    return increased
end

println(process_lines(lines))
println(process_lines_2(lines))
lines = readlines(ARGS[1])


function solution1(lines)
    horizontal = 0
    depth = 0
    for line in lines
        command, distance = split(line)
        int_distance = parse(Int, distance)
        if command == "up"
            depth -= int_distance
        elseif command == "down"
            depth += int_distance
        elseif command == "forward"
            horizontal += int_distance
        else
            throw(Exception(command, "unknown input"))
        end
    end
    return depth * horizontal
end

function solution2(lines)
    horizontal = 0
    depth = 0
    aim = 0
    for line in lines
        command, distance = split(line)
        int_distance = parse(Int, distance)
        if command == "up"
            aim -= int_distance
        elseif command == "down"
            aim += int_distance
        elseif command == "forward"
            horizontal += int_distance
            depth += aim * int_distance
        else
            throw(Exception(command, "unknown input"))
        end
    end
    return depth * horizontal
end

println(solution1(lines))
println(solution2(lines))
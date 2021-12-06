lines = readlines(ARGS[1])

function solution1(lines)
    hit_map = Dict()
    for line in lines
        coords = []
        step = 1
        for sub_block in split(line, " -> ")
            append!(coords, [parse(Int, x) for x in split(sub_block, ",")])
        end

        x_diff = coords[1] - coords[3]
        y_diff = coords[2] - coords[4]

        if x_diff == 0
            if coords[2] > coords[4]
                step = -1
            end
            for i = coords[2]:step:coords[4]
                entry = string(coords[1], ",", i)
                if entry in keys(hit_map)
                    hit_map[entry] += 1
                else
                    hit_map[entry] = 1
                end
            end
        elseif y_diff == 0
            if coords[1] > coords[3]
                step = -1
            end
            for i = coords[1]:step:coords[3]
                entry = string(i, ",", coords[2])
                if entry in keys(hit_map)
                    hit_map[entry] += 1
                else
                    hit_map[entry] = 1
                end
            end
        else
            println("skip")
        end
    end
    return length([k for (k, v) in hit_map if v >= 2])
end

function solution2(lines)
    hit_map = Dict()
    for line in lines
        coords = []
        step = 1
        for sub_block in split(line, " -> ")
            append!(coords, [parse(Int, x) for x in split(sub_block, ",")])
        end

        x_diff = coords[1] - coords[3]
        y_diff = coords[2] - coords[4]

        if x_diff == 0
            if coords[2] > coords[4]
                step = -1
            end
            for i = coords[2]:step:coords[4]
                entry = string(coords[1], ",", i)
                if entry in keys(hit_map)
                    hit_map[entry] += 1
                else
                    hit_map[entry] = 1
                end
            end
        elseif y_diff == 0
            if coords[1] > coords[3]
                step = -1
            end
            for i = coords[1]:step:coords[3]
                entry = string(i, ",", coords[2])
                if entry in keys(hit_map)
                    hit_map[entry] += 1
                else
                    hit_map[entry] = 1
                end
            end
        elseif abs(x_diff) == abs(y_diff)
            y_step = 1
            if x_diff > 0
                step = -1
            end
            if y_diff > 0
                y_step = -1
            end
            for (x_pos, y_pos) in zip(coords[1]:step:coords[3], coords[2]:y_step:coords[4])
                entry = string(x_pos, ",", y_pos)
                if entry in keys(hit_map)
                    hit_map[entry] += 1
                else
                    hit_map[entry] = 1
                end
            end
        else
            println("skip")
        end
    end
    return length([k for (k, v) in hit_map if v >= 2])
end

println(solution1(lines))
println(solution2(lines))
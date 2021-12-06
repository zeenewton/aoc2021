lines = readlines(ARGS[1])


function solution1(lines)
    fishes = [parse(Int, f) for f in split(lines[1], ",")]

    for i = 1:80
        next_gen = []
        new_fishes = []
        for fish in fishes
            if fish == 0
                append!(new_fishes, 8)
                append!(next_gen, 6)
            else
                append!(next_gen, fish - 1)
            end

        end
        append!(next_gen, new_fishes)
        fishes = next_gen
    end
    println(length(fishes))
end

function solution2(lines)
    fishes = [parse(Int8, f) for f in split(lines[1], ",")]
    fish_dict = Dict()
    for fish in fishes
        if fish in keys(fish_dict)
            fish_dict[fish] += 1
        else
            fish_dict[fish] = 1
        end
    end
    println(fish_dict)
    for i = 1:256
        next_gen = Dict()
        if 0 in keys(fish_dict)
            next_gen[8] = fish_dict[0]
        end

        for fish_key in keys(fish_dict)
            if fish_key != 0
                next_gen[fish_key-1] = fish_dict[fish_key]
            end
        end
        if 6 in keys(next_gen)
            if 0 in keys(fish_dict)
                next_gen[6] += fish_dict[0]
            end
        else
            if 0 in keys(fish_dict)
                next_gen[6] = fish_dict[0]
            end
        end

        fish_dict = next_gen
        println(i, ":", sum([value for value in values(fish_dict)]))
    end
    println(sum([value for value in values(fish_dict)]))
end

solution1(lines)

solution2(lines)
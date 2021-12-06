lines = readlines(ARGS[1])

function solution1(lines)
    hit_map = Dict()
    for line in lines
        coords = []
        for sub_block in split(line, " -> ")
            append!(coords, [split(sub_block, ",")])
        end
        # coords = [(x,y for (x,y) in split(sub_block, ",")) for sub_block in split(line, " -> ")]
        if coords[1][1] == coords[2][1] 
            for i in parse(Int,coords[1][2]):parse(Int,coords[2][2])
                entry = string(coords[1][1],",", i) 
                if entry in keys(hit_map)
                    hit_map[entry] += 1
                else
                    hit_map[entry] = 1
                end
            end
        elseif coords[1][2] == coords[2][2]
            for i in parse(Int,coords[1][1]):parse(Int,coords[2][1])
                entry = string(i, ",", coords[1][2]) 
                if entry in keys(hit_map)
                    hit_map[entry] += 1
                else
                    hit_map[entry] = 1
                end
            end
        else
            println("SKIP")
        end
    end
    println(hit_map)
    return size([k for (k,v) in hit_map if v >= 2])
end

println(solution1(lines))
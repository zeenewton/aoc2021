lines = readlines(ARGS[1])
vals = [parse(Int, x) for x in split(lines[1], ",")]

function solution1(vals)
    min_val = min(vals...)
    max_val = max(vals...)

    target = nothing
    for candidate = min_val:max_val
        total_fuel = sum([abs(x - candidate) for x in vals])
        if isnothing(target)
            target = total_fuel
        elseif total_fuel < target
            target = total_fuel
        end
    end
    return target
end


function fuel_burnt(val1, val2)
    return sum([x for x = 1:abs(val1 - val2)])
end

function solution2(vals)
    min_val = min(vals...)
    max_val = max(vals...)

    target = nothing
    for candidate = min_val:max_val
        total_fuel = sum([fuel_burnt(x, candidate) for x in vals])
        if isnothing(target)
            target = total_fuel
        elseif total_fuel < target
            target = total_fuel
        end
    end
    return target
end

println(solution1(vals))
println(solution2(vals))
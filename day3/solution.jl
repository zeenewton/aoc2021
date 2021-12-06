lines = readlines(ARGS[1])

function mode(mat)
    mode_array = []
    for col in mat
        val_dict = Dict()
        for i in col
            if i in keys(val_dict)
                val_dict[i] += 1
            else
                val_dict[i] = 1
            end
        end
        max_count = nothing
        max_val = nothing
        for i in keys(val_dict)
            if isnothing(max_count)
                max_count = val_dict[i]
                max_val = i
            elseif val_dict[i] > max_count
                max_count = val_dict[i]
                max_val = i
            end
        end
        append!(mode_array, parse(Int, max_val))
    end
    return mode_array
end

function flip_bit(val_array)
    eps_array = []
    for i in val_array
        if i == 0
            append!(eps_array, 1)
        elseif i == 1
            append!(eps_array, 0)
        end
    end
    return eps_array
end

function bin_array_to_int(bin_array)
    output = 0
    for i in length(bin_array):-1:1
        output += bin_array[i] * 2^(length(bin_array)-i)
    end
    return output
end

function calculate_product(val_array)
    eps_array = flip_bit(val_array)
    gamma = bin_array_to_int(val_array)
    epsilon = bin_array_to_int(eps_array)
    return epsilon*gamma
end

function solution1(lines)
    line_length = nothing
    val_matrix = []
    for line in lines
        if isnothing(line_length)
            line_length = length(line)
            for i in 1:line_length
                append!(val_matrix, [[]])
            end
        end
        for i in 1:line_length
            append!(val_matrix[i], line[i])
        end

    end

    res = []
    for i in 1:line_length
        append!(res, val_matrix[i])
    end
    return calculate_product(mode(val_matrix))
    
end

function solution2(lines)

end

println(solution1(lines))
println(solution2(lines))
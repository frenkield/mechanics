using Plots

mutable struct System

    q::Vector{Float64}
    p::Vector{Float64}
    masses::Vector{Float64}

    function System(particle_count::Int)
        system = new(zeros(particle_count), zeros(particle_count))
        system.masses = ones(particle_count)
        return system
    end

end

function size(system::System)
    return length(system.p)
end

function Plots.plot(system::System)  
    plot(system.q[1:1], system.q[2:2], marker = (:dot, 5))
    display(plot!(system.q[4:4], system.q[5:5], marker = (:dot, 5)))
end

# function Plots.plot!(system::System)
#     return plot!(system.q[1:1], system.q[2:2], marker = (:dot, 5))
# end

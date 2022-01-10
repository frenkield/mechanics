


Base.@kwdef mutable struct System

    q::Vector{Float64}
    p::Vector{Float64}
    mass = 1.0

    function System(particle_count::Int)
        system = new(zeros(particle_count), zeros(particle_count), 1.0)
        return system
    end

end

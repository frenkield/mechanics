using LinearAlgebra
include("system.jl")

mutable struct GravitationalPotential

    q::Vector{Float64}
    particle1::SubArray{Float64, 1, Vector{Float64}, Tuple{UnitRange{Int64}}, true}
    particle2::SubArray{Float64, 1, Vector{Float64}, Tuple{UnitRange{Int64}}, true}

    function GravitationalPotential(system::System)

        potential = new()
        potential.q = system.q
        potential.particle1 = @view system.q[1:3]
        potential.particle2 = @view system.q[4:6]
        return potential

    end

end

# function compute_accelerations!(system::System, q::Vector{Float64},
#     masses::Vector{Float64},
#     accelerations::Vector{Float64})

function compute_accelerations!(potential::GravitationalPotential,
                                particle1::SubArray{Float64, 1, Vector{Float64}, Tuple{UnitRange{Int64}}, true},
                                particle2::SubArray{Float64, 1, Vector{Float64}, Tuple{UnitRange{Int64}}, true})

    r = norm(particle1 - particle2)

    # r = norm(potential.particle1 - potential.particle2)

    # for i in 1:3
    #     accelerations[i] = (q[i + 3] - q[i]) / (r^3) * masses[i + 3]
    #     accelerations[i + 3] = -accelerations[i] / masses[i + 3] * masses[i]
    # end

end

# function compute_potential_energy(system::System)

#     q = system.q
#     masses = system.masses
#     r = norm(q[1:3] - q[4:6])

#     return -1/r * masses[1] * masses[4]    
# end

# function compute_forces!(system::System, forces::Vector{Float64})

#     q = system.q
#     masses = system.masses
#     r = norm(q[1:3] - q[4:6])

#     for i in 1:3
#         forces[i] = (q[i + 3] - q[i]) / (r^3) * masses[i + 3] * masses[i]
#         forces[i + 3] = -forces[i]
#     end

# end

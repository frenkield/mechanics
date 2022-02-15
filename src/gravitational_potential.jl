using LinearAlgebra
include("system.jl")

function compute_forces!(system::System, forces::Vector{Float64})

    q = system.q
    masses = system.masses
    r = norm(q[1:3] - q[4:6])

    for i in 1:3
        forces[i] = (q[i + 3] - q[i]) / (r^3) * masses[i + 3] * masses[i]
        forces[i + 3] = -forces[i]
    end

end

function compute_accelerations!(system::System, accelerations::Vector{Float64})

    q = system.q
    masses = system.masses
    r = norm(q[1:3] - q[4:6])

    for i in 1:3
        accelerations[i] = (q[i + 3] - q[i]) / (r^3) * masses[i + 3]
        accelerations[i + 3] = -accelerations[i] / masses[i + 3] * masses[i]
    end

end

function compute_potential_energy()

    # energy = 0.5 * sum(p.^2)
    # energy -= 1/r
    # println(energy)

end

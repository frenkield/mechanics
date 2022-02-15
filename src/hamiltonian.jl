# using LinearAlgebra
include("system.jl")
include("gravitational_potential.jl")

Base.@kwdef mutable struct Hamiltonian
    system = System(6)
end

function q_dot(hamiltonian::Hamiltonian, index::Int)
    return hamiltonian.system.p[index] / hamiltonian.system.mass
end

function q_dot(hamiltonian::Hamiltonian)
    return hamiltonian.system.p / hamiltonian.system.mass
end

function p_dot(hamiltonian::Hamiltonian, index1::Int)
    q = hamiltonian.system.q
    d = norm(q[1:3] - q[4:6])
    index2 = index1 <= 3 ? index1 + 3 : index1 - 3
    return (q[index1] - q[index2]) / d
end

function p_dot(hamiltonian::Hamiltonian)

    q = hamiltonian.system.q
    d = norm(q[1:3] - q[4:6])

    p_dot = [
        q[1] - q[4], q[2] - q[5], q[3] - q[6],
        q[4] - q[1], q[5] - q[2], q[6] - q[3]
    ]

    p_dot /= d
    return p_dot

end

function size(hamiltonian::Hamiltonian)
    return size(hamiltonian.system)
end

# function compute_forces!(hamiltonian::Hamiltonian)
#     compute_forces!(hamiltonian.system, hamiltonian.forces)
# end

# function compute_accelerations!(hamiltonian::Hamiltonian)
#     compute_accelerations!(hamiltonian.system, hamiltonian.  accelerations)
# end

function energy()

        # energy = 0.5 * sum(p.^2)
    # energy -= 1/r
    # println(energy)

end
include("hamiltonian.jl")
# include("coordinates.jl")

mutable struct Verlet

    # coordinates::Coordinates
    hamiltonian::Hamiltonian
    forces::Array{Float64, 1}

    time_step::Float64

    function Verlet(hamiltonian::Hamiltonian)

        verlet = new(hamiltonian)
        verlet.forces = zeros(size(hamiltonian.system))
        verlet.time_step = 0.05    
        return verlet

    end

end



# U(r) = 1/r

# r = sqrt(x^2 - y^2)

# dr/dx = 1/2 * (x^2 - y^2)^(-1/2) * 2x
#       = x/r

# dU/dx = dU/dr * dr/dx  = -1/r^2 * x/r = -x/r^3



function iterate!(verlet::Verlet)

    forces = verlet.forces
    q = verlet.hamiltonian.system.q
    p = verlet.hamiltonian.system.p

    r = norm(q[1:3] - q[4:6])

    for i in 1:3
        forces[i] = (q[i + 3] - q[i]) / (r^3)
        forces[i + 3] = -forces[i]
    end

    p_t_half = p .+ (0.5 * verlet.time_step) * forces

    q .+= verlet.time_step * p_t_half

    for i in 1:3
        forces[i] = (q[i + 3] - q[i]) / (r^3)
        forces[i + 3] = -forces[i]
    end

    p .= p_t_half .+ (0.5 * verlet.time_step) * forces

end



# function iterate_verlet!(scheme::Scheme)

#     rotor_chain = scheme.rotor_chain
#     rotor_chain_length = length(rotor_chain)

#     if scheme.first_iteration
#         for i in 1:rotor_chain_length
#             scheme.forces[i] = calculate_rotor_force(scheme, i)
#         end
#         scheme.first_iteration = false
#     end

#     # iteration p^{n + 1/2}
#     for i in 1:rotor_chain_length
#         rotor_chain.rotors[i].p += scheme.forces[i]
#     end

#     # iteration q^{n + 1}
#     for i in 1:rotor_chain_length
#         rotor_chain.rotors[i].q += scheme.time_step * rotor_chain.rotors[i].p
#     end

#     # iteration p^{n + 1}
#     for i in 1:rotor_chain_length
#         scheme.forces[i] = calculate_rotor_force(scheme, i)
#         rotor_chain.rotors[i].p += scheme.forces[i]
#     end

# end

# function iterate!(scheme::Scheme)
#     iterate_ornstein_uhlenbeck!(scheme)
#     iterate_verlet!(scheme)
# end

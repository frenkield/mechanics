using Test
include("../src/verlet.jl")

function test1()

    hamiltonian = Hamiltonian()
    verlet = Verlet(hamiltonian)
    hamiltonian.system.q = [-1.0, 0, 0, 1, 0, 0]
    iterate!(verlet)

    @test hamiltonian.system.p == [0.049968750000000006, 0.0, 0.0, -0.049968750000000006, 0.0, 0.0]
    @test hamiltonian.system.q == [-0.99875, 0.0, 0.0, 0.99875, 0.0, 0.0]
    
    plot(hamiltonian.system)
    
end


function test2()

    hamiltonian = Hamiltonian()
    verlet = Verlet(hamiltonian)
    hamiltonian.system.q = [-1.0, 0, 0, 1, 0, 0]

    for i in 1:2000

        println(verlet.forces)

        iterate!(verlet)

        plot(hamiltonian.system)

        sleep(0.1)
    end

end

function test3()

    hamiltonian = Hamiltonian()
    verlet = Verlet(hamiltonian)

    hamiltonian.system.q = [-1.0, 0, 0,
                            1, 0, 0]

    hamiltonian.system.p = [0.0, 0.5, 0,
                            0, -0.5, 0]

    for i in 1:2000

        # println(verlet.forces)

        iterate!(verlet)

        plot(hamiltonian.system)

        sleep(0.05)
    end

end

function test4()

    hamiltonian = Hamiltonian()
    verlet = Verlet(hamiltonian)

    hamiltonian.system.q = [-1.0, 0, 0,
                            1, 0, 0]

    hamiltonian.system.p = [0.0, 0, 0,
                            0, 1.0, 0]

    hamiltonian.system.masses = [10.0, 10, 10,
                                 1, 1, 1]

    for i in 1:1000

        # println(hamiltonian.system.q)



        iterate!(verlet)

        # println(verlet.hamiltonian.forces)
        # println(verlet.hamiltonian.system.q)

        plot(hamiltonian.system)

        # sleep(0.05)
    end

end




function test5()

    hamiltonian = Hamiltonian()
    verlet = Verlet(hamiltonian)

    hamiltonian.system.q = [0.0, 0, 0,
                            10, 0, 0]

    hamiltonian.system.p = [0.0, 0.0, 0,
                            0, 20, 0]

    mass1 = 10000
    mass2 = 1
    hamiltonian.system.masses = [mass1, mass1, mass1,
                                 mass2, mass2, mass2]

    for i in 1:10000

        iterate!(verlet)
        plot(hamiltonian.system)

        # sleep(0.05)
    end

end





default(xlims= (-15, 15), ylims = (-15, 15))
plot()

test5()





# println(hamiltonian.system.p)


########################################



# display(plot!(particle2))       

# mutable struct Verlet

#     coordinates::Coordinates
#     hamiltonian::Hamiltonian
#     forces::Array{Float64, 1}

#     time_step::Float64
#     half_time_step::Float64

#     first_iteration::Bool

#     function Scheme(rotor_chain::RotorChain, temperature_left::Float64,
#                     temperature_right::Float64, external_force::Float64,
#                     time_step = 0.05)

#         half_time_step = time_step / 2.0
#         alpha = exp(-gamma * time_step)

#         thermostat_left = Thermostat(alpha, temperature_left)
#         thermostat_right = Thermostat(alpha, temperature_right)

#         scheme = new(rotor_chain, thermostat_left, thermostat_right, external_force,
#                      time_step, half_time_step, alpha)

#         scheme.hamiltonian = Hamiltonian()
#         scheme.forces = zeros(rotor_chain.length)
#         scheme.first_iteration = true

#         return scheme

#     end

# end

# function iterate_ornstein_uhlenbeck!(scheme::Scheme)

#     rotor_chain = scheme.rotor_chain

#     first_rotor(rotor_chain).p = (scheme.alpha * rotor_chain.rotors[1].p) +
#                                  force(scheme.thermostat_left)

#     last_rotor(rotor_chain).p = scheme.external_force +
#                                 (scheme.alpha * (last_rotor(rotor_chain).p - scheme.external_force)) +
#                                 force(scheme.thermostat_right)
# end


# function calculate_rotor_force(scheme::Scheme, rotor_index::Int)
#    return -scheme.half_time_step *
#           rotor_force(scheme.hamiltonian, scheme.rotor_chain, rotor_index)
# end

# ##
# # On peut faire les iterations en-place car \frac{\partial H}{\partial q}
# # ne depend pas de p.
# ##
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

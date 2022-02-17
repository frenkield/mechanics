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

    hamiltonian.system.q .= [0.0, 0, 0,
                             10, 0, 0]

    hamiltonian.system.p .= [0.0, 0.0, 0,
                             0, 20, 0]

    mass1 = 10000
    mass2 = 1
    hamiltonian.system.masses .= [mass1, mass1, mass1,
                                  mass2, mass2, mass2]

    iterate!(verlet)

    # p = hamiltonian.system.p

    # for i in 1:1000000

    #     # println(compute_energy(hamiltonian))

    #     iterate!(verlet, p)
    #     # plot(hamiltonian.system)

    #     # sleep(0.05)
    # end

end





default(xlims= (-15, 15), ylims = (-15, 15))
plot()

test5()

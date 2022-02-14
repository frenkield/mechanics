using Test
include("../src/hamiltonian.jl")

function test1()

    hamiltonian = Hamiltonian()
    @test size(hamiltonian) == 6

    q = hamiltonian.system.q

    q[1] = 1.0
    q[4] = -1.0

    @test q_dot(hamiltonian, 1) == 0
    @test p_dot(hamiltonian, 1) == 1
    @test p_dot(hamiltonian, 4) == -1

    p_dot_array = p_dot(hamiltonian)

    for i in 1:length(p_dot_array)
        @test p_dot_array[i] == p_dot(hamiltonian, i)
    end

end

function test2()

    hamiltonian = Hamiltonian()
    q = hamiltonian.system.q

    for i in 1:length(q)
        q[i] = rand()
    end

    p_dot_array = p_dot(hamiltonian)

    for i in 1:length(p_dot_array)
        @test p_dot_array[i] == p_dot(hamiltonian, i)
    end

end

test1()
test2()

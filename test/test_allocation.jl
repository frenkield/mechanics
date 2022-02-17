include("../src/gravitational_potential.jl")

struct A

    q::Vector{Float64}

    function A()
        a = new(zeros(10000000))
        return a
    end

end

function fill_via_struct(a::A)
    for j in 1:1
        for i in 1:length(a.q)
            a.q[i] = 1.0
        end
    end
end

function fill_directly(q::Vector{Float64})
    for j in 1:100
        for i in 1:length(q)
            q[i] = 1.0
        end
    end
end



function accelerations_struct(potential::GravitationalPotential)

r = norm(potential.particle1 - potential.particle2)

# r = norm(potential.particle1 - potential.particle2)

# for i in 1:3
#     accelerations[i] = (q[i + 3] - q[i]) / (r^3) * masses[i + 3]
#     accelerations[i + 3] = -accelerations[i] / masses[i + 3] * masses[i]
# end
end

function accelerations_direct(particle1::Vector{Float64}, particle2::Vector{Float64})

    r = norm(particle1 - particle2)
    
    # r = norm(potential.particle1 - potential.particle2)
    
    # for i in 1:3
    #     accelerations[i] = (q[i + 3] - q[i]) / (r^3) * masses[i + 3]
    #     accelerations[i + 3] = -accelerations[i] / masses[i + 3] * masses[i]
    # end
    
end


function test_potential()

    # system = System(6)
    # potential = GravitationalPotential(system)

    particle1 = [1.0, 2, 4]
    particle2 = [5.0, 6, 3]
    result = [0.0, 0.0, 0.0]
    r = 0.0

    for i in 1:10000000

        for j in 1:3
            result[j] = particle1[j] + particle2[j]
        end

        # particle1 .- particle2
        # r = norm(particle1 - particle2)

    end
end


using Plots
include("../src/particle.jl")


function test1()

    particle = Particle()
    particle.q[1] = -1.0

    for i in 1:5
        display(plot!(particle))
        move!(particle, [0.1, 0, 0])
        sleep(0.5)
    end

end

function test2()

    particle1 = Particle()
    particle1.mass = 10.0
    particle1.q[1] = -1.0
    particle1.p[2] = 1.0

    particle2 = Particle()
    particle2.q[1] = 1.0
    particle2.p[2] = -1.0

    particle1_p_dot = [0.0, 0.0, 0.0]
    particle2_p_dot = [0.0, 0.0, 0.0]

    for i in 1:1000

        plot(particle1)
        display(plot!(particle2))       

        d = distance(particle1, particle2)

        particle1_p_dot[1] = (particle2.q[1] - particle1.q[1]) / d
        particle2_p_dot[1] = -particle1_p_dot[1]

        particle1_p_dot[2] = (particle2.q[2] - particle1.q[2]) / d
        particle2_p_dot[2] = -particle1_p_dot[2]

        particle1.p += (particle1_p_dot * 0.01)
        particle2.p += (particle2_p_dot * 0.01)

        move!(particle1)
        move!(particle2)

        # sleep(0.01)
    end

end


default(xlims= (-2, 2), ylims = (-2, 2))
plot()

test2()

# display(plot!())

println("done")

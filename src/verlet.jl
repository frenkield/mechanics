include("hamiltonian.jl")
# include("coordinates.jl")

mutable struct Verlet

    # coordinates::Coordinates
    hamiltonian::Hamiltonian
    forces::Vector{Float64}
    accelerations::Vector{Float64}
    p_t_half::Vector{Float64}

    time_step::Float64
    half_time_step::Float64

    potential::GravitationalPotential


    function Verlet(hamiltonian::Hamiltonian)

        verlet = new(hamiltonian)
        verlet.forces = zeros(size(hamiltonian.system))
        verlet.accelerations = zeros(size(hamiltonian.system))
        verlet.p_t_half = zeros(size(hamiltonian.system))

        verlet.time_step = 0.0001    
        verlet.half_time_step =  verlet.time_step / 2

        verlet.potential = GravitationalPotential(hamiltonian.system)

        return verlet

    end

end



# U(r) = 1/r

# r = sqrt(x^2 - y^2)

# dr/dx = 1/2 * (x^2 - y^2)^(-1/2) * 2x
#       = x/r

# dU/dx = dU/dr * dr/dx  = -1/r^2 * x/r = -x/r^3

function iterate!(verlet::Verlet)

    q = verlet.hamiltonian.system.q
    p = verlet.hamiltonian.system.p
    masses = verlet.hamiltonian.system.masses
    accelerations = verlet.accelerations
    p_t_half = verlet.p_t_half

    for i in 1:1000000

        # println(compute_energy(hamiltonian))

        iterate!(verlet, q, p, masses, accelerations, p_t_half)
        # plot(hamiltonian.system)

        # sleep(0.05)
    end


end

function iterate!(verlet::Verlet, q::Vector{Float64}, p::Vector{Float64}, masses::Vector{Float64},
                  accelerations::Vector{Float64}, p_t_half::Vector{Float64})

    system = verlet.hamiltonian.system
    # compute_accelerations!(system, q, masses, accelerations)
    compute_accelerations!(verlet.potential, verlet.potential.particle1, verlet.potential.particle2)

    # p_t_half .= p .+ verlet.half_time_step * accelerations

    for i in 1:size(system)
       p_t_half[i] = p[i] + verlet.half_time_step * accelerations[i]
    end

    # system.q += verlet.time_step * verlet.p_t_half
    
    # compute_accelerations!(verlet.hamiltonian.system, verlet.accelerations)

    # system.p .= verlet.p_t_half .+ verlet.half_time_step * verlet.accelerations

end

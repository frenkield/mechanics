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
        verlet.time_step = 0.001    
        return verlet

    end

end



# U(r) = 1/r

# r = sqrt(x^2 - y^2)

# dr/dx = 1/2 * (x^2 - y^2)^(-1/2) * 2x
#       = x/r

# dU/dx = dU/dr * dr/dx  = -1/r^2 * x/r = -x/r^3



function iterate!(verlet::Verlet)

    forces = verlet.hamiltonian.forces
    q = verlet.hamiltonian.system.q
    p = verlet.hamiltonian.system.p

    compute_forces!(verlet.hamiltonian)

    p_t_half = p .+ (0.5 * verlet.time_step) * forces

    q .+= verlet.time_step * p_t_half
    
    compute_forces!(verlet.hamiltonian)

    p .= p_t_half .+ (0.5 * verlet.time_step) * forces

end

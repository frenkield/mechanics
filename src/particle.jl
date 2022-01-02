using LinearAlgebra
using Plots

mutable struct Particle

    q::Array{Float64}
    p::Array{Float64}
    mass::Float64

    function Particle()
        particle = new()
        particle.q = [0.0, 0.0, 0.0]
        particle.p = [0.0, 0.0, 0.0]
        particle.mass = 1.0
        return particle
    end

end

function move!(particle::Particle, velocity::Array{Float64})
    particle.q += velocity * 0.1
end

function move!(particle::Particle)
    move!(particle, particle.p / particle.mass)
end

function distance(particle1::Particle, particle2::Particle)
    return norm(particle1.q - particle2.q)
end

function Plots.plot(particle::Particle)
    return plot(particle.q[1:1], particle.q[2:2], marker = (:dot, 5))
end

function Plots.plot!(particle::Particle)
    return plot!(particle.q[1:1], particle.q[2:2], marker = (:dot, 5))
end




# Base.@kwdef mutable struct Lorenz
#     dt::Float64 = 0.02
#     σ::Float64 = 10
#     ρ::Float64 = 28
#     β::Float64 = 8/3
#     x::Float64 = 1
#     y::Float64 = 1
#     z::Float64 = 1
# end
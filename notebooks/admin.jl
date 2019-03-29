"""
These are helper functions called in the tests of
synthetic_multidim.ipynb notebook
"""

using Distributions

"""
gen_test_particles: Helper function for testing stuff. Generates dictionary with
keys as params and values as array of particles
"""
function gen_test_particles(num_p)
    # start:step:end and number of particles are the inputs to sample
    v_particles = sample(10.0:1.0:30.0,num_p)
    sig_particles = sample(0.1:0.1:1.0,num_p)
    p_set_dict = Dict(:v_des=>v_particles,:σ=>sig_particles)
    return p_set_dict
end

"""
to_matrix_form: Return information and more workable form for initial particle set

---------Arguments:
`p_set_dict` Dictionary with parameters of IDM as keys and associated value as array of particles

---------Returned things that need explanation:
`p_mat` Matrix with each row corresponding to a different parameter of IDM, and each column to a diff particle
`params` Array of parameters eg: [:v_des,:σ]
`vec_val_vec` Array with each element being another array. This array contains the values i.e diff particles
"""
function to_matrix_form(p_set_dict)
    # Get the number of particles
    # Extract keys (i.e. params) and corresponding array of values
    num_p = -100
    num_params = length(keys(p_set_dict))
    
    params = Array{Symbol}(undef,num_params,1)
    vec_val_vec = Array{Array}(undef,num_params,1) #Array containing associated values for each key
    for (kk,kv) in enumerate(p_set_dict)
        num_p = length(kv[2])
        params[kk] = kv[1]
        vec_val_vec[kk] = kv[2]
    end
    
    # Create a matrix with different rows being different parameters and diff cols being diff particles
    p_mat = hcat(vec_val_vec...)'
    
    return p_mat, params, vec_val_vec
end

"""
Create a new dictionary with param and associated particle value array
"""
function to_dict_form(params,new_p_mat)
    num_params = length(params)
    new_p_set_dict = Dict()
    for k in 1:num_params
        new_p_set_dict[params[k]] = new_p_mat[k,:]
    end
    return new_p_set_dict
end
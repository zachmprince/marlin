[Domain]
  dim = 2
  nx = 10
  ny = 10
  mesh_mode = DUMMY
  parallel_mode = REAL_SPACE
  periodic_directions = 'X Y'
[]

[Stencil]
  [d2q9]
    type = LBMD2Q9
  []
[]

[TensorBuffers]
  [f]
    type = LBMTensorBuffer
    buffer_type = df
  []
  [f_bounce_back]
    type = LBMTensorBuffer
    buffer_type = df
  []
  [velocity]
    type = LBMTensorBuffer
    buffer_type = mv
  []
  [density]
    type = LBMTensorBuffer
    buffer_type = ms
  []
[]

[Functions]
  [vel_ramp]
    type = PiecewiseLinear
    x = '0 100'
    y = '0 1'
  []
[]

[TensorComputes]
  [Initialize]
    [initial_density]
      type = LBMConstantTensor
      buffer = density
      constants = 1.0
    []
    [initial_velocity]
      type = LBMConstantTensor
      buffer = velocity
      constants = '0.0 0.0'
    []
    [initial_f]
      type = LBMEquilibrium
      buffer = f
      bulk = density
      velocity = velocity
    []
    [initial_f_bb]
      type = LBMEquilibrium
      buffer = f_bounce_back
      bulk = density
      velocity = velocity
    []
  []
  [Solve]
    [density]
      type = LBMComputeDensity
      buffer = density
      f = f
    []
    [velocity]
      type = LBMComputeVelocity
      buffer = velocity
      f = f
      rho = density
    []
  []
  [Boundary]
    [left]
      type = LBMFixedFirstOrderBC
      buffer = f
      f = f
      value = 0.1
      function = vel_ramp
      boundary = left
    []
    [right]
      type = LBMMicroscopicZeroGradientBC
      buffer = f
      boundary = right
    []
    [top]
      type = LBMBounceBack
      buffer = f
      f_old = f_bounce_back
      boundary = top
    []
    [bottom]
      type = LBMBounceBack
      buffer = f
      f_old = f_bounce_back
      boundary = bottom
    []
  []
[]

[TensorSolver]
  type = LBMStream
  buffer = f
  f_old = f_bounce_back
[]

[Problem]
  type = LatticeBoltzmannProblem
  substeps = 20
[]

[Postprocessors]
  [velocity_max]
    type = TensorExtremeValuePostprocessor
    buffer = velocity
    value_type = MAX
  []
[]

[Executioner]
  type = Transient
  num_steps = 6
[]

[Outputs]
  csv = true
[]

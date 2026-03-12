# LBMFixedFirstOrderBC

!syntax description /TensorComputes/Boundary/LBMFixedFirstOrderBC

LBMFixedFirstOrderBC implements Zou\-He velocity boundary conditions at the inlet and outlet for D2Q9, D3Q19 and D3Q27 stencils.

## Overview

Enforces first\-order accurate macroscopic velocity at selected domain faces via Zou\-He formulas.
Choose faces with [!param](/TensorComputes/Boundary/LBMFixedFirstOrderBC/boundary) and provide
macroscopic fields as required by the implementation.

## Example Input File Syntax

!listing lbm/vertical_velocity_bcs.i block=TensorComputes/Boundary/top TensorComputes/Boundary/bottom

This boundary condition also allows for time-varying velocity:

!listing lbm/ramped_velocity_bcs.i block=Functions TensorComputes/Boundary/left

!syntax parameters /TensorComputes/Boundary/LBMFixedFirstOrderBC

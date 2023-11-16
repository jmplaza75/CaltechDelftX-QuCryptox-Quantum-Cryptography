# Copyright (c) 2016, QuTech, TU Delft, written by W. Hekman and S. Wehner
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
#################
#
# partialTrace
# 
# Traces out the middle system from A, B, C
# A and C can be one dimensional, in which case we just trace over half a bipartite state 
#
# Input:
# 	rho: density matrix of A, B, C
# 	nA:  dimension of A
# 	nB:  dimension of B
# 	nC:  dimension of C
# Output:
#	reduced density matrix on A and C
#

function partialTrace(rho,nA, nB, nC)

	# Check the size of rho
	totalDim = nA * nB * nC;
	(d1,d2) = size(rho);
	if (d1 != d2)
		error("Rho must be a square matrix.");
		return;
	end
	if(d1 != totalDim)
		error("Dimensions don't match the state.");
		return;
	end

	# Prepare to compute the partial trace, inefficiently but instructive by measuring the 
	# system to be traced out in the standard basis
	#
	# ketPT(nA,nB,nC,j) = I_A tensor |j>_B tensor I_C and the corresponding braPT perform the measurement
	# corresponding to outcome j
	#
	procList = [braPT(nA,nB,nC,j)*rho*ketPT(nA,nB,nC,j) for j in 1:nB];
	outRho = sum(procList);

	return outRho;

end

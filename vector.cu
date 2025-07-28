#include <stdio.h>

__global__ void vecAddKernel(float *A_d, float *B_d, float *C_d, int n)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n)
    {
        C_d[i] = A_d[i] + B_d[i];
    }
}

void vecAdd(float *A_h, float *B_h, float *C_h, int n)
{
    float *A_d, *B_d, *C_d;

    int size = n * sizeof(float);
    cudaMalloc((void **)&A_d, size);
    cudaMalloc((void **)&B_d, size);
    cudaMalloc((void **)&C_d, size);

    cudaMemcpy(A_d, A_h, n, cudaMemcpyHostToDevice);
    cudaMemcpy(B_d, B_h, n, cudaMemcpyHostToDevice);

    vecAddKernel<<<ceil(n / 256.0), 256>>>(A_d, B_d, C_d, n);

    cudaMemcpy(C_h, C_d, n, cudaMemcpyDeviceToHost);
    cudaFree(A_d);
    cudaFree(B_d);
    cudaFree(C_d);
}

int main()
{
    int n = 1000; // Example size
    float A_h[n], B_h[n], C_h[n];

    // Initialize A_h and B_h with some values
    for (int i = 0; i < n; i++)
    {
        A_h[i] = i * 1.0f;
        B_h[i] = i * 2.0f;
    }

    // Call the vector addition function
    vecAdd(A_h, B_h, C_h, n);

    // Print the result for verification
    for (int i = 0; i < 10; i++)
    {
        printf("C[%d] = %f\n", i, C_h[i]);
    }

    return 0;
}

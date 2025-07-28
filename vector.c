#include <stdio.h>

void vecAdd(float *A_h, float *B_h, float *C_h, int n)
{
    for (int i = 0; i < n; i++)
    {
        C_h[i] = A_h[i] + B_h[i];
    }
}

int main()
{
    int n = 10; // Example size
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
    for (int i = 0; i < n; i++)
    {
        printf("C[%d] = %f\n", i, C_h[i]);
    }

    return 0;
}

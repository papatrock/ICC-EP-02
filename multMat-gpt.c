void multMatVet(MatRow mat, Vetor v, int m, int n, Vetor res) {
    /* Inicializa o vetor de resultados */
    if (res) {
        for (int i = 0; i < m; ++i) {
            res[i] = 0; // Zera o resultado para cada linha da matriz
        }

        // Multiplicação
        for (int i = 0; i < m; ++i) {
            double sum = 0.0;
            int j = 0;

            // Unroll and jam: processa 4 elementos por iteração
            for (; j <= n - 4; j += 4) {
                sum += mat[n * i + j] * v[j] +
                       mat[n * i + j + 1] * v[j + 1] +
                       mat[n * i + j + 2] * v[j + 2] +
                       mat[n * i + j + 3] * v[j + 3];
            }

            // Processa os elementos restantes
            for (; j < n; ++j) {
                sum += mat[n * i + j] * v[j];
            }

            res[i] += sum; // Armazena o resultado da linha
        }
    }
}

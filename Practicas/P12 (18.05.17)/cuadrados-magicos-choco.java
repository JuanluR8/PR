//Carlos Piña Martinez, Juan Luis Romero Sanchez

package choco;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.variables.IntVar;

public class Overview {

	public static void main(String[] args) {
		// 1. Create a Model
		Model model = new Model("Cuadrado magico");
		
		// 2. Create variables
		int N = 3;
		IntVar[][] matriz = model.intVarMatrix("X", N, N, 1, N*N);
		IntVar magic = model.intVar("magic", (N*(N*N + 1) /2) );
		
//		for (int i = 0; i < N; i++){
//			for (int j = 0; j < N; j++)
//				matriz[i][j] = model.intVar("matriz" + i + "_" + j, 0, N);
//		}
		
		// 3. Post constraints
		//Todos diferentes
		IntVar[] todos = model.intVarArray("todos", N*N, 1, N*N);
		for (int i = 0; i < N; i++){
			for(int j = 0; j < N; j++){
				todos[i*N+j] = matriz[i][j];
			}
		}
		
		model.allDifferent(todos).post();
		

		//Diferentes por filas
		for (int i = 0; i < N; i++){
			//obtener la fila
			IntVar[] fila = model.intVarArray("fila", N, 1, N*N);
			for(int j = 0; j < N; j++){
				fila[j] = matriz[i][j];
			}
			model.sum(fila, "+", magic).post();
		}
		
		//Diferentes por columnas
		for (int i = 0; i < N; i++){
			//obtener la columna
			IntVar[] columna = model.intVarArray("columna", N, 1, N*N);
			for(int j = 0; j < N; j++){
				columna[j] = matriz[j][i];
			}
			model.sum(columna, "+", magic).post();
		}
		
		//Diferentes en diagonal
			//obtener la diagonal
		IntVar[] diagonal_a = model.intVarArray("diagonal_a", N, 1, N*N);
		for(int j = 0; j < N; j++){
			diagonal_a[j] = matriz[j][j];
		}
		model.sum(diagonal_a, "+", magic).post();
		
		IntVar[] diagonal_b = model.intVarArray("diagonal_b", N, 1, N*N);
		for(int j = 0; j < N; j++){
			diagonal_b[j] = matriz[N-1-j][j];
		}
		model.sum(diagonal_b, "+", magic).post();
		
		// 4. Solve the problem
		model.getSolver().solve();
		
		// 5. Print the solution
		for (int i = 0; i < N; i++){
			for (int j = 0; j < N; j++)
				System.out.print(matriz[i][j].getValue()+" ");
			System.out.println("");
		}
	}
}

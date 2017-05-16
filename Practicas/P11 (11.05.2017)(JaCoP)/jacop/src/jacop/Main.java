package jacop;

import org.jacop.constraints.Alldifferent;
import org.jacop.constraints.Constraint;
import org.jacop.constraints.Sum;
import org.jacop.core.IntVar;
import org.jacop.core.Store;
import org.jacop.search.DepthFirstSearch;
import org.jacop.search.IndomainMin;
import org.jacop.search.Search;
import org.jacop.search.SelectChoicePoint;
import org.jacop.search.SimpleMatrixSelect;
import org.jacop.search.SmallestMax;

public class Main {
	public static void main(String[] args){
		final int n = 4;
		final int v = n*(n*n+1)/2;
		
		Store store = new Store();
		
		//array [1..n, 1..n] of var 1..n*n: a;
		IntVar [][] a =  new IntVar [n][n];
		
		for (int i=0; i<n; i++){
			for (int j=0; j<n; j++){
				a[i][j] = new IntVar (store, "a_"+i+"_"+j, 1, n*n);
			}
		}
		
		//Diferentes por filas
		for (int i = 0; i < n; i++){
			//obtener la fila
			IntVar []fila = new IntVar[n];
			for(int j = 0; j < n; j++){
				fila[j] = a[i][j];
			}
			Constraint ctr = new Sum(fila, new IntVar(store, "fila"+i, v,v));
			store.impose(ctr);
		}
		
		//Diferentes por columnas
		for (int i = 0; i < n; i++){
			//obtener la volumna
			IntVar []columna = new IntVar[n];
			for(int j = 0; j < n; j++){
				columna[j] = a[j][i];
			}
			Constraint ctr = new Sum(columna, new IntVar(store, "fila"+i, v,v));
			store.impose(ctr);
		}
		
		//Diferentes por filas
		IntVar []todos = new IntVar[n*n];
		for (int i = 0; i < n; i++)
			//obtener la fila
			for(int j = 0; j < n; j++)
				todos[i*n+j] = a[i][j];
			
		Constraint ctr = new Alldifferent(todos);
		store.impose(ctr);
		
		
		Search<IntVar> label = new DepthFirstSearch<IntVar>();
		SelectChoicePoint<IntVar> select = new SimpleMatrixSelect<IntVar>(
				a,
				new SmallestMax<IntVar>(),
				new IndomainMin<IntVar>()
		);
		boolean result = label.labeling(store, select);
		
		for (int i=0; i<n; i++){
			for (int j=0; j<n; j++){
				System.out.print(a[i][j]+" ");
			}
			System.out.println("");
		}
	} 
}

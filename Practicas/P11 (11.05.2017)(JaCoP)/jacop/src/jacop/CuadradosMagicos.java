package jacop;

import org.jacop.constraints.Alldifferent;
import org.jacop.constraints.Constraint;
import org.jacop.constraints.Count;
import org.jacop.constraints.XeqC;
import org.jacop.core.BoundDomain;
import org.jacop.core.IntVar;
import org.jacop.core.Store;
import org.jacop.search.DepthFirstSearch;
import org.jacop.search.IndomainMin;
import org.jacop.search.InputOrderSelect;
import org.jacop.search.Search;
import org.jacop.search.SelectChoicePoint;
import org.jacop.set.core.SetVar;
import org.jacop.set.constraints.EinA;

public class CuadradosMagicos {
    final static int equipos=6; // un número par
    final static int partidos = equipos/2;
    final static int semanas = equipos*(equipos-1)/(equipos/2);

     
    /**
     * Convierte índices de un array tridimensional en índices de un array plano
     * @param i Indica la semana de juego. 0<=i<semanas
     * @param j Indica el número de partido dentro de la semana. 0<=j<partidos
     * @param k Para el partido (i,j) indica si se trata del que juega en casa (k=0) 
     *          o el visitante (k=1) 
     * @return indice en el array aplanado
     */
    public static int indice(int i, int j, int k) {
    	return i*partidos*2+j*2+k;
    }
	public static void main(String[] args) {
        // representamos los partidos como un array plano a
		Store store = 	new		Store();
 		// convertir x en un array plano a
		IntVar[] a = new IntVar[semanas*partidos*2];
		for (int i=0; i<semanas; i++) {
			for (int j=0; j<partidos; j++) {
				for (int k=0; k<2; k++)
					a[indice(i,j,k)] = new IntVar(store, "x_"+i+"_"+j+"_"+k,1, equipos );
			}
		}

        //////////// aquí va el código de la práctica /////////////////////
		/////////// mostrar el resultado ////////////////////////////////////
		

		Search<org.jacop.core.IntVar> search =	new DepthFirstSearch<org.jacop.core.IntVar>();
		SelectChoicePoint<org.jacop.core.IntVar> select =
		new	InputOrderSelect<org.jacop.core.IntVar>(store, a,new IndomainMin<org.jacop.core.IntVar>());
		boolean resultado = search.labeling(store, select);
        if (resultado) {// mostrar
    		for (int i=0; i<semanas; i++) {
    			
    			System.out.println("Semana: "+(i+1));

    			for (int j=0; j<partidos; j++) {
    					System.out.println("    " + a[indice(i,j,0)].value()+ "-" +a[indice(i,j,1)].value());
    			}
    	
    		}
        } else
        	System.out.println("no hay solución");

	}

}


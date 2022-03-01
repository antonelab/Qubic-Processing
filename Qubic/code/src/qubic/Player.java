package qubic;

import java.util.ArrayList;
import java.util.Scanner;
import java.util.Collections;

public class Player {
        //oznaka igraca
        private char id;
        public String name;

        //algoritam min max
        private Pair<Integer, Move> minMax(Cube cube, ArrayList<Move> moves, char id, int alpha, int beta, int maxDepth)
        {
            Pair<Integer, Move> result = new Pair<>();
            Integer value;

            //terminal state  
            value = cube.result();
            if(value != null){
                result.first = value;
                return result;
            }

            int n = moves.size();
            Move move;
            Pair<Integer, Move> temp;

            //maksimana dubina
            if(maxDepth <= 0){
                if(id == 'X') result.first = cube.heuristic('X','O');
                else result.first = cube.heuristic('O','X');
                return result;
            }

            //max
            if(id == 'X'){
                result.first = -1000;
                for(int i=0; i<n; i++){
                    move = moves.remove(0);
                    cube.play(move, 'X');
                    temp = minMax(cube, (ArrayList) moves.clone(), 'O', alpha, beta, maxDepth-1);
                    moves.add(move);
                    cube.unPlay(move);
                    if(temp.first>result.first){
                        result.first=temp.first;
                        result.second = move;
                        alpha = Math.max(alpha, result.first); 
                    }
                    if (beta <= alpha) break;
                    //kad naidemo na 500 sigurno necemo naci bolje pa izlazimo
                    if(result.first==500)break;
                }
            }

            //min
            else if(id == 'O'){
                result.first=1000;
                for(int i=0; i<n; i++){
                    move = moves.remove(0);
                    cube.play(move, 'O');
                    temp = minMax(cube, (ArrayList) moves.clone(), 'X', alpha, beta, maxDepth-1);
                    moves.add(move);
                    cube.unPlay(move);
                    if(temp.first<result.first){
                        result.first=temp.first;
                        result.second=move;
                        beta = Math.min(beta, result.first);
                    }
                    if (beta <= alpha) break;
                    //kad naidemo na -500 sigurno necemo naci bolje pa izlazimo
                    if(result.first==-500)break;
                }
            }
            return result;
        }
        
        //Konstruktor
        public Player(char id)
        {
            this.id = id;
        }

        //Funkcija vraca ime igraca
        public char id()
        {
            return id;
        }
        
        //Funkcija vraća optimalni potez
        public Move hint(Cube cube){
            //System.out.println("Hint za " + id);
            Pair<Integer, Move> result = new Pair<>();
            ArrayList<Move> moves = cube.generate_moves();
            Collections.shuffle(moves);

            int alpha = -1000;
            int beta = 1000;
            for(int i = 1; i <= cube.maxDepth(); i++){
                try
                {
                    Thread.sleep(10);
                    result = minMax(cube, moves, id, alpha, beta, i);
                    //System.out.println(i + "    " + result.first);
                    if(result.first==-500 || result.first==500)break;
                }
                catch(InterruptedException ex)
                {
                    Thread.currentThread().interrupt();
                    return null;
                }
            }

            //u situaciji kada ne mozemo pobijediti
            //idemo maksimalno otezati protivniku
            if(id == 'O' && result.first > 0){
                
                for(int i = 1; i <= cube.maxDepth(); i++){
                    try
                    {
                        Thread.sleep(10);
                        result = minMax(cube, moves, 'X', alpha, beta, i);
                        if(result.first==-500 || result.first==500)break;
                    }
                    catch(InterruptedException ex)
                    {
                        Thread.currentThread().interrupt();
                        return null;
                    }  
                }
            }

            else if(id == 'X' && result.first < 0){
                for(int i = 1; i <= cube.maxDepth(); i++){
                    try
                    {
                        Thread.sleep(10);
                        result = minMax(cube, moves, 'O', alpha, beta, i);
                        if(result.first==-500 || result.first==500)break;
                    }
                    catch(InterruptedException ex)
                    {
                        Thread.currentThread().interrupt();
                        return null;
                    }
                }
            }
            
            //System.out.println(result.second);
            return result.second;
        }
        
}

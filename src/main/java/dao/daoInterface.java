package dao;

import java.util.ArrayList;

public interface daoInterface<T> {
	public int insert(T t);
	
	public int update(T t);
	
	public int delete(T t);
	
	public ArrayList<T> selectAll();
	
	public T selectById(int id);
	
	public ArrayList<T> selectByCondition(String condition);
}

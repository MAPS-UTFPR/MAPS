package mAPS;

import com.sleepycat.bind.tuple.TupleBinding;
import com.sleepycat.bind.tuple.TupleInput;
import com.sleepycat.bind.tuple.TupleOutput;
import com.sleepycat.je.DatabaseEntry;

public class DriverBD {
	
	private String id;
	private int myTrust;
	
	public DriverBD(){}
	
	public DriverBD(String id, int myTrust){
		this.id = id;
		this.myTrust = myTrust;
	}	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getMyTrust() {
		return myTrust;
	}

	public void setMyTrust(int myTrust) {
		this.myTrust = myTrust;
	}

	public DatabaseEntry objectToEntry() {

		TupleOutput output = new TupleOutput();
		DatabaseEntry entry = new DatabaseEntry();
		output.writeString(String.valueOf(getMyTrust()));
		TupleBinding.outputToEntry(output, entry);
		return entry;
	}
	
	public void entryToObject(DatabaseEntry entry) {

		TupleInput input = TupleBinding.entryToInput(entry);

		// set id and trust
		setMyTrust(Integer.valueOf((input.readString())));
		
	}
	
	
	@Override
	public String toString() { return this.id.concat(" - " + this.myTrust); }

	

}

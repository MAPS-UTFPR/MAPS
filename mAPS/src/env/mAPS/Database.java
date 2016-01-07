// CArtAgO artifact code for project mAPS

package mAPS;

import java.io.File;

import com.sleepycat.bind.tuple.StringBinding;
import com.sleepycat.je.DatabaseConfig;
import com.sleepycat.je.DatabaseEntry;
import com.sleepycat.je.Environment;
import com.sleepycat.je.EnvironmentConfig;
import com.sleepycat.je.OperationStatus;

import cartago.Artifact;

public class Database extends Artifact {
	void init(int initialValue) {	
		System.out.println("Database starting...");
		
	}

	private void openDataBase() {

		try {
			// create a configuration for DB environment
			EnvironmentConfig envConf = new EnvironmentConfig();
			// environment will be created if not exists
			envConf.setAllowCreate(true);

			// open/create the DB environment using config
			Environment dbEnv = new Environment(new File("lib/db"), envConf);

			// create a configuration for DB
			DatabaseConfig dbConf = new DatabaseConfig();
			// db will be created if not exits
			dbConf.setAllowCreate(true);

			// create/open testDB using config
			com.sleepycat.je.Database mapsDB = dbEnv.openDatabase(null, "MAPS_DB", dbConf);

			// key
			DatabaseEntry key = new DatabaseEntry();
			// data
			DatabaseEntry data = new DatabaseEntry();

			DriverBD dv = new DriverBD("m1", 400);

			// assign the driver ID to the key
			StringBinding.stringToEntry(dv.getId(), key);

			// insert into database
			mapsDB.put(null, key, dv.objectToEntry());
			dv.setMyTrust(dv.getMyTrust()+5);
			mapsDB.put(null, key, dv.objectToEntry());
			
			
			StringBinding.stringToEntry("m1", key);
			
			if(mapsDB.get(null, key, data, null) == OperationStatus.SUCCESS){
				dv.entryToObject(data);
				System.out.println(dv);
			}

			// important: do not forget to close them!
			mapsDB.close();
			dbEnv.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static void main(String[] args) {
		Database d  = new Database();
		d.openDataBase();
	}
	
}

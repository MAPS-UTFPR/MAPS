// CArtAgO artifact code for project mAPS

package mAPS;

import java.io.File;

import com.sleepycat.bind.tuple.StringBinding;
import com.sleepycat.je.Database;
import com.sleepycat.je.DatabaseConfig;
import com.sleepycat.je.DatabaseEntry;
import com.sleepycat.je.Environment;
import com.sleepycat.je.EnvironmentConfig;
import com.sleepycat.je.OperationStatus;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

public class DBControl extends Artifact {

	private Database mapsDB;
	private Environment dbEnv;
	private DriverBD driver;
	private DatabaseEntry key = new DatabaseEntry(), data = new DatabaseEntry();
	
	private final int INITIAL_TRUST_VALUE = 0; 

	void init(String msg) {
		System.out.println("Database starting...");		
		openDataBase();

	}

	private void openDataBase() {

		try {
			// create a configuration for DB environment
			EnvironmentConfig envConf = new EnvironmentConfig();
			// environment will be created if not exists
			envConf.setAllowCreate(true);

			// open/create the DB environment using config
			dbEnv = new Environment(new File("lib/db"), envConf);

			// create a configuration for DB
			DatabaseConfig dbConf = new DatabaseConfig();
			// db will be created if not exits
			dbConf.setAllowCreate(true);

			// create/open mapsDB using config
			mapsDB = dbEnv.openDatabase(null, "MAPS_DB", dbConf);	
			System.out.println("deu boa!");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	@OPERATION
	public void insertOrUpdateDriver(String idDriver, int trustDriver) {
		
		key = new DatabaseEntry();
		data = new DatabaseEntry();		
		driver = new DriverBD(idDriver,Integer.valueOf(trustDriver));
		
		// assign the driver ID to the key
		StringBinding.stringToEntry(driver.getId(), key);

		// insert into database
		mapsDB.put(null, key, driver.objectToEntry());
		System.out.println("INSERIU");

	}
	
	@OPERATION
	public void getDriver(String idDriver, OpFeedbackParam<Object> trustDriver){
		
		driver = new DriverBD(idDriver);
		try{
			StringBinding.stringToEntry(driver.getId(), key);
			if (mapsDB.get(null, key, data, null) == OperationStatus.SUCCESS)
				driver.entryToObject(data);		
			
			else
				insertOrUpdateDriver(driver.getId(), INITIAL_TRUST_VALUE);
				
			trustDriver.set(driver.getMyTrust());

		} catch (Exception e){
			e.printStackTrace();			
		}
			
	}	

	public void closeDB() {
		mapsDB.close();
		dbEnv.close();
	}

	
}

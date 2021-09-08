<?php

date_default_timezone_set("Asia/Kolkata");

class Db {

    private $pdo;
    private $stmt;

    function __construct() {
        // set database setting here 
        $host='localhost'; $db='apptest_api'; $u='root'; $p='';
        
		try {
            $this->pdo = new PDO("mysql:charset=utf8mb4;host={$host};dbname={$db}", $u, $p);
            
			$this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            
        } catch (PDOException $e) {
            $this->pdo = null;
            //echo $e->getMessage();
            return 'oops: You have an error in your sql syntax check the manual';
        }
    }

    function __destruct() {
        // release all resource
        $this->stmt = null;
        $this->pdo = null;
    }

    // initialize prepare statement
    public function prepare_statement($sql) {
        $this->stmt = $this->pdo->prepare($sql);
    }

    //financial year and month
    public function getFYandMonthFromYear($month, $year) {
        date_default_timezone_set('Asia/Kolkata');
        if ($month > '3') {
            $FY = $year . '-' . substr(($year + 1), 2);
            $nextFY = ($year + 1) . '-' . substr(($year + 2), 2);
        } else if (date('m') < '4') {
            $FY = ($year - 1) . '-' . substr($year, 2);
            $nextFY = $year . '-' . substr(($year + 1), 2);
        }

        $timeReq['month'] = $month;
        $timeReq['fy'] = $FY;
        $timeReq['next_fy'] = $nextFY;
        return $timeReq;
    }

    // bind parameter
    public function set_val($field_nm, $field_val) {
        $this->stmt->bindParam($field_nm, $field_val);
    }

    // initialize prepare statement for update data using array
    public function update_by_array($tbl_name, $where, $array_data) {
        $sets = "Update {$tbl_name} set ";
        foreach ($array_data as $field => $value) {
            $sets .= "{$field} = :{$field}, ";
        }
        $sets = substr($sets, 0, -2) . $where;
        $this->prepare_statement($sets);
        foreach ($array_data as $field => $value) {
            $this->set_val(":{$field}", $value);
        }
        return $this->exe_update_insert();
    }

    //////// execute statement and return records from mysql
    public function get_record_exe_stat() {
        try {
            $this->stmt->execute();
            return $this->stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            //echo $e->getMessage();
            $this->pdo = null;
            return 'oops: You have an error in your sql syntax check the manual';
        }
    }

    /// execute statement and return updated/inserted no of rows/row
    public function exe_update_insert() {
        try {

            $this->stmt->execute();
            //$this->stmt->debugDumpParams();
            return $this->stmt->rowCount();
        } catch (PDOException $e) {
            $this->stmt->debugDumpParams();
           // echo $e->getMessage();
            $this->pdo = null;
            return 'oops: You have an error in your sql syntax check the manual';
        }
    }

/// execute statement and return exe_delete no of rows/row
    public function exe_delete() {
        try {
            $this->stmt->execute();
            return $this->stmt->rowCount();
        } catch (PDOException $e) {
            //$this->stmt->debugDumpParams();
            $this->pdo = null;
            return 'oops: You have an error in your sql syntax check the manual';
        }
    }

    /// Return number of rows that are after delete/update/insert 
    public function get_row_count() {
        try {
            $this->stmt->rowCount();
        } catch (PDOException $e) {
            //echo $e->getMessage();
            $this->pdo = null;
            return 0;
        }
    }

/// Return last auto increment id after insert record
    public function get_last_id() {
        try {
            return $this->pdo->lastInsertId();
        } catch (PDOException $e) {
            $this->pdo = null;
            return 0;
        }
    }

/// Return records of sql query
    public function get_record_by_sql($sql) {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            //echo $e->getMessage();
            $this->pdo = null;
            return 'oops: You have an error in your sql syntax check the manual';
        }
    }

/// Insert record and return number of rows effected
    public function insert_by_sql($sql) {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute();
            return $stmt->rowCount();
        } catch (PDOException $e) {
            //echo $e->getMessage();
            $this->pdo = null;
            return 'oops: You have an error in your sql syntax check the manual';
        }
    }

    public function reset_stmt() {
        $this->stmt = null;
        $this->pdo = null;
    }

}

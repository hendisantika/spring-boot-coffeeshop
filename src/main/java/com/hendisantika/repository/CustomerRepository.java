package com.hendisantika.repository;

import com.hendisantika.model.Customer;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by hendisantika on 24/12/16.
 */
public interface CustomerRepository extends CrudRepository<Customer, Long>{

}

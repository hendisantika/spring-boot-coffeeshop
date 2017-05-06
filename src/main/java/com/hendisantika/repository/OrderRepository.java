package com.hendisantika.repository;

import com.hendisantika.model.CustomerOrder;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by hendisantika on 01/01/17.
 */
public interface OrderRepository extends CrudRepository<CustomerOrder,Long>{

}

let autocomplete;

function initAutoComplete(){
    autocomplete=new google.maps.places.Autocomplete(
        document.getElementById('id_address'),{
            types:['geocode','establishment'],
            componentRestrictions:{'country':['NP']},
        }
    )
    autocomplete.addListener('place_changed',onPlacedChanged)
}
function onPlacedChanged() {
    // Get place details from the autocomplete object
    let place = autocomplete.getPlace();

    if (!place.geometry) {
        // If no geometry is returned, prompt user to type a valid address
        document.getElementById('id_address').placeholder = 'Start typing...';
    } else {
        
        var geocoder=new google.maps.Geocoder()
        var address=document.getElementById('id_address').value
        geocoder.geocode({'address':address},function(results,status){
            if(status==google.maps.GeocoderStatus.OK){
                var latitude=results[0].geometry.location.lat()
                var longitude=results[0].geometry.location.lng()
                console.log(latitude,longitude)
                $('#id_latitude').val(latitude)
                $('#id_longitude').val(longitude)
            }
        })
        for(var i=0 ;i<place.address_components.length;i++)
            {
                for(var j=0 ;j<place.address_components[i].types.length ;j++)
                {
                    if(place.address_components[i].types[j]=='country'){
                        $('#id_country').val(place.address_components[i].long_name)
                    }
                    if(place.address_components[i].types[j]=='administrative_area_level_1'){
                        $('#id_state').val(place.address_components[i].long_name)
                    }
                    if(place.address_components[i].types[j]=='postal_code'){
                        $('#id_pin_code').val(place.address_components[i].long_name)
                    }
        
        
                }
            }


    }

   
   
}

$(document).ready(function(){
    $('.add_to_cart').on('click',function(e){
        e.preventDefault()
        food_id=$(this).attr('data-id')
        url=$(this).attr('data-url')
        data={
            food_id: food_id,

        }
        
        $.ajax({
            type:'GET',
            'url':url,
            data:data,
            success:function(response){
                if(response.status=='login_required'){
                    swal(response.message,'Please login the website','info').then(function(){
                        window.location='/accounts/login'
                    })
               
                }
                else if(response.status=='Failed'){
                    swal(response.message,'','error')
                }
                else{
                    $('#cart_counter').html(response.cart_counter['cart_count'])
                    $('#qty-'+food_id).html(response.qty)
                     
                    applyCartAmount(response.cart_amount['subtotal'],
                    response.cart_amount['tax'],
                    response.cart_amount['grand_total'])
                }
                
                

            }

        })
        
    })
    $('.decrease_cart').on('click',function(e){
        e.preventDefault()
        food_id=$(this).attr('data-id')
        url=$(this).attr('data-url')
        cart_id=$(this).attr('id')
      
        
        $.ajax({
            type:'GET',
            'url':url,
           
            success:function(response){
                if(response.status=='login_required'){
                    swal(response.message,'Please login the website','info').then(function(){
                        window.location='/accounts/login'
                    })
               
                }
                else if(response.status=='failed'){
                    swal(response.message,'','error')
                }
                else{
                    $('#cart_counter').html(response.cart_counter['cart_count'])
                    $('#qty-'+food_id).html(response.qty)
                    applyCartAmount(response.cart_amount['subtotal'],
                        response.cart_amount['tax'],
                        response.cart_amount['grand_total'])
                    if(window.location.pathname=='/cart/')
                        {
                            removeCartItem(response.qty,cart_id)
                        }
                   
                }
                
  
                

            }

        })
        
    })
    $('.delete_cart').on('click',function(e){
        e.preventDefault()
        
        cart_id=$(this).attr('data-id')
        url=$(this).attr('data-url')
      
        
        $.ajax({
            type:'GET',
            'url':url,
           
            success:function(response){
                if(response.status=='Failed'){
                    swal(response.message,'','info')
                    
               
                }
                else{
                    $('#cart_counter').html(response.cart_counter['cart_count'])
                    swal(response.status,response.message,'success')
                    applyCartAmount(response.cart_amount['subtotal'],
                        response.cart_amount['tax'],
                        response.cart_amount['grand_total'])
                    removeCartItem(0,cart_id)
                }
                
  
                

            }

        })
        
    })
    // delete the cartitem if the qty is 0
           function removeCartItem(cartItemqty,cart_id){
            
                if(cartItemqty <=0)
                    {
                        document.getElementById('cart-item-'+cart_id).remove()
                        checkEmptyCart();
        
                    }

             
           


           }

       function checkEmptyCart(){
         var cart_counter= document.getElementById('cart_counter').innerHTML
         if(cart_counter==0){
            document.getElementById('empty-cart').style.display='block'
         }
       }   
       //apply cart amounts
       function applyCartAmount(subtotal,tax,grand_total){
        if(window.location.pathname=='/cart/'){
           $('#subtotal').html(subtotal)
           $('#tax').html(tax)
           $('#total').html(grand_total)
        }

       }
    //place the cart item quantity  on load 
    $('.item_qty').each(function(){
        var the_id=$(this).attr('id')
        var qty=$(this).attr('data-qty')
        $('#'+the_id).html(qty)

    })
})
class buyNowRequest
{
	module = "MarXet";
	parameters[] = {"STRING","SCALAR"};
};
class buyerBuyNowResponse
{
	module = "MarXet";
	parameters[] = {"ARRAY","STRING","SCALAR","STRING"};
};
class sellerBuyNowResponse
{
	module = "MarXet";
	parameters[] = {"ARRAY","STRING"};
};
class createNewListingRequest
{
	module = "MarXet";
	parameters[] = {"ARRAY"};
};
class createNewListingResponse
{
	module = "MarXet";
	parameters[] = {"BOOL","STRING","STRING","SCALAR"};
};
class updateInventoryRequest
{
    module = "MarXet";
    parameters[] = {"SCALAR"};
};
class updateInventoryResponse
{
	module = "MarXet";
	parameters[] = {"ARRAY"};
};

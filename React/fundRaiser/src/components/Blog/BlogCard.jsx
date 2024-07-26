import React from "react";

function BlogCard({props}){
    return (
        <>
        <div className=" bg-green-200 w-[450px] rounded-2xl shadow-md p-8 flex-col justify-center m-8 cursor-pointer hover:shadow-xl hover:scale-105 duration-100">
                    <div className="font-bold text-2xl text-center">
                        FUNDS TITLE
                    </div>
                    <div className="mt-5">
                        <img src="/src/images/fundcard.jpg" alt="" className="rounded-lg" />
                    </div>

                    <div className="flex mt-5">
                        <div>
                           #FOOD
                        </div>
                    </div>
                </div>
        </>
    );
}

export default BlogCard;
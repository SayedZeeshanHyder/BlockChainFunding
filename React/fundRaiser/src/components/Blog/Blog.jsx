import React from "react";
import NavBar from "../NavBar/NavBar";
import BlogCard from "./BlogCard";


function Blog() {
    return (
        <>
            <div className="w-72 mt-2 ml-2">
                <img src="/src/images/Glorious Purpose.svg" alt="" />
            </div>

            <NavBar username="USERNAME" />

            <div className="absolute top-16 left-72 right-10">

                <div className="flex w-[98%] flex-wrap h-[90vh] overflow-y-auto ">
                <BlogCard />
                <BlogCard/>
                <BlogCard/>
                <BlogCard/>
                <BlogCard/>
                <BlogCard/>
                </div>
            </div>
           

          
          

        </>
    );
}

export default Blog;